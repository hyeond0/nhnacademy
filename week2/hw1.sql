#1 영화 '퍼스트 맨'의 제작 연도, 영문 제목, 러닝 타임, 플롯을 출력하세요.
select ReleaseYear 제작연도, title 영문제목, RunningTime 러닝타임, plot 플롯
from movie
where KoreanTitle = '퍼스트 맨';
#2 2003년에 개봉한 영화의 한글 제목과 영문 제목을 출력하세요
select title 영문제목, KoreanTitle 한글제목
from movie
where ReleaseYear = 2003;
#3 영화 '글래디에이터'의 작곡가를 고르세요
select KoreanName 이름, Name 영문이름, KoreanTitle 영화, RoleKorName 역할
from person p
         join appear a on p.PersonID = a.PersonID
         join movie m on a.MovieID = m.MovieID
         join role r on a.RoleID = r.RoleID
where m.KoreanTitle = '글래디에이터'
  and r.RoleKorName = '작곡';
#4 영화 '매트릭스' 의 감독이 몇명인지 출력하세요
select count(*) 감독수
from role r
         join appear a on r.RoleID = a.RoleID
         join movie m on a.MovieID = m.MovieID
where RoleKorName = '감독'
  and KoreanTitle = '매트릭스';
#5 감독이 2명 이상인 영화를 출력하세요
select m.Title, m.KoreanTitle, count(a.PersonID) 감독
from movie m
         join appear a on m.MovieID = a.MovieID
         join role r on a.RoleID = r.RoleID
where r.RoleKorName = '감독'
group by m.MovieID
having 감독 >= 2;
#6 '한스 짐머'가 참여한 영화 중 아카데미를 수상한 영화를 출력하세요
select title 제목, KoreanTitle 한글제목, ay.Year 수상연도
from movie m
         join appear a on m.MovieID = a.MovieID
         join person p on a.PersonID = p.PersonID
         join awardinvolve ai on a.AppearID = ai.AppearId
         join awardyear ay on ai.AwardYearID = ay.AwardYearID
         join award aw on ay.AwardID = aw.AwardID
         join winning w on ai.WinningID = w.WinningID
where p.KoreanName = '한스 짐머'
  and aw.AwardKoreanTitle = '아카데미 영화제'
  and w.WinOrNot = 'Winner';
#7 감독이 '제임스 카메론'이고 '아놀드 슈워제네거'가 출연한 영화를 출력하세요
select m.title 제목, m.KoreanTitle 한글제목
from movie m
         join appear a on m.MovieID = a.MovieID
         join role r on a.RoleID = r.RoleID
         join person p on a.PersonID = p.PersonID
where KoreanName = '아놀드 슈워제네거'
  and RoleKorName = '배우'
  and m.movieId in (select m.MovieID
                    from movie m
                             join appear a on m.MovieID = a.MovieID
                             join role r on a.RoleID = r.RoleID
                             join person p on a.PersonID = p.PersonID
                    where KoreanName = '제임스 카메론'
                      and RoleKorName = '감독');
#8 상영시간이 100분 이상인 영화 중 레오나르도 디카프리오가 출연한 영화를 고르시오
select distinct title 제목, KoreanTitle 한글제목
from movie m
         join appear a on m.MovieID = a.MovieID
         join person p on a.PersonID = p.PersonID
where m.RunningTime >= 100
  and p.KoreanName = '레오나르도 디카프리오';
#9 청소년 관람불가 등급의 영화 중 가장 많은 수익을 얻은 영화를 고르시오
select Title 제목, KoreanTitle 한글제목, BoxOfficeWWGross 수익
from movie m
         join gradeinkorea gi on m.GradeInKoreaID = gi.GradeInKoreaID
where gi.GradeInKoreaName = '청소년 관람불가'
order by m.BoxOfficeWWGross desc
limit 1;
#10 1999년 이전에 제작된 영화의 수익 평균을 고르시오
select count(MovieID) 영화, avg(BoxOfficeWWGross) 수익평균
from movie m
where ReleaseYear < 1999;
#11 가장 많은 제작비가 투입된 영화를 고르시오.
select Title 제목, KoreanTitle 한글제목, Budget
from movie
order by Budget desc
limit 1;
#12 제작한 영화의 제작비 총합이 가장 높은 감독은 누구입니까?
select p.KoreanName 이름, sum(Budget) 총예산, count(m.MovieID) 제작영화수
from movie m
         join appear a on m.MovieID = a.MovieID
         join role r on a.RoleID = r.RoleID
         join person p on a.PersonID = p.PersonID
where r.RoleKorName = '감독'
group by p.personId
order by 총예산 desc
limit 1;
#13 출연한 영화의 모든 수익을 합하여, 총 수입이 가장 많은 배우를 출력하세요.
select Name 이름, KoreanName 한글이름, sum(BoxOfficeWWGross) 총수입, count(a.MovieID) 출연영화수
from movie m
         join appear a on m.MovieID = a.MovieID
         join role r on a.RoleID = r.RoleID
         join person p on a.PersonID = p.PersonID
where r.RoleKorName = '배우'
group by p.PersonID
order by 총수입 desc
limit 1;
#14 제작비가 가장 적게 투입된 영화의 수익을 고르세요. (제작비가 0인 영화는 제외합니다)
select title 제목, KoreanTitle 한글제목, Budget 예산
from movie m
where budget > 0
order by budget
limit 1;
#15 제작비가 5000만 달러 이하인 영화의 미국내 평균 수익을 고르세요
select count(BoxOfficeUSGross) 영화수, avg(BoxOfficeUSGross) 미국내평균수익
from movie
where Budget <= 50000000;
#16 액션 장르 영화의 평균 수익을 고르세요
select count(BoxOfficeWWGross) 영화수, avg(m.BoxOfficeWWGross) 평균수익
from movie m
         join moviegenre mg on m.MovieID = mg.MovieID
         join genre g on mg.GenreID = g.GenreID
where g.GenreKorName = '액션';
#17 드라마, 전쟁 장르의 영화를 고르세요.
select Title 제목, KoreanTitle 한글제목, g.GenreKorName 장르
from movie m
         join moviegenre mg on m.MovieID = mg.MovieID
         join genre g on mg.GenreID = g.GenreID
where g.GenreKorName = '전쟁'
   or g.GenreKorName = '드라마';
#18 톰 행크스가 출연한 영화 중 상영 시간이 가장 긴 영화의 제목, 한글제목, 개봉연도를 출력하세요.
select Title 제목, KoreanTitle 한글제목, ReleaseYear 개봉연도
from movie m
         join appear a on m.MovieID = a.MovieID
         join person p on a.PersonID = p.PersonID
where p.KoreanName = '톰 행크스'
order by RunningTime desc
limit 1;
#19 아카데미 남우주연상을 가장 많이 수상한 배우를 고르시오
select p.KoreanName 이름, count(p.personId) 수상횟수
from person p
         join appear a on p.PersonID = a.PersonID
         join awardinvolve ai on a.AppearID = ai.AppearID
         join awardyear ay on ai.AwardYearID = ay.AwardYearID
         join award aw on ay.AwardID = aw.AwardID
         join sector s on ai.SectorID = s.SectorID
         join winning w on ai.WinningID = w.WinningID
where aw.AwardKoreanTitle = '아카데미 영화제'
  and w.WinOrNot = 'winner'
  and s.SectorKorName = '남우주연상'
group by p.PersonID
order by 수상횟수 desc
limit 1;
#20 아카데미상을 가장 많이 수상한 배우를 고르시오 ('수상자 없음'이 이름인 영화인은 제외합니다)
select p.KoreanName 이름, count(p.personId) 수상횟수
from person p
         join appear a on p.PersonID = a.PersonID
         join role r on a.RoleID = r.RoleID
         join awardinvolve ai on a.AppearID = ai.AppearID
         join awardyear ay on ai.AwardYearID = ay.AwardYearID
         join award aw on ay.AwardID = aw.AwardID
         join winning w on ai.WinningID = w.WinningID
where aw.AwardKoreanTitle = '아카데미 영화제'
  and w.WinOrNot = 'winner'
  and r.RoleKorName = '배우'
  and p.KoreanName != '수상자 없음'
group by p.PersonID
order by 수상횟수 desc
limit 1;
#21 아카데미 남우주연상을 2번 이상 수상한 배우를 고르시오
select p.KoreanName 이름, count(p.personId) 수상횟수
from person p
         join appear a on p.PersonID = a.PersonID
         join awardinvolve ai on a.AppearID = ai.AppearID
         join awardyear ay on ai.AwardYearID = ay.AwardYearID
         join award aw on ay.AwardID = aw.AwardID
         join sector s on ai.SectorID = s.SectorID
         join winning w on ai.WinningID = w.WinningID
where aw.AwardKoreanTitle = '아카데미 영화제'
  and w.WinOrNot = 'winner'
  and s.SectorKorName = '남우주연상'
group by p.PersonID
having 수상횟수 >= 2;
#23 아카데미상을 가장 많이 수상한 사람을 고르세요.
select p.KoreanName 이름, count(p.personId) 수상횟수
from person p
         join appear a on p.PersonID = a.PersonID
         join awardinvolve ai on a.AppearID = ai.AppearID
         join awardyear ay on ai.AwardYearID = ay.AwardYearID
         join award aw on ay.AwardID = aw.AwardID
         join winning w on ai.WinningID = w.WinningID
where aw.AwardKoreanTitle = '아카데미 영화제'
  and w.WinOrNot = 'winner'
  and p.KoreanName != '수상자 없음'
group by p.PersonID
order by 수상횟수 desc
limit 1;
#24 아카데미상에 가장 많이 노미네이트 된 영화를 고르세요.
select KoreanTitle 이름, count(aw.AwardID) 노미네이트_횟수
from movie m
         join appear a on m.MovieID = a.MovieID
         join awardinvolve ai on a.AppearID = ai.AppearID
         join awardyear ay on ai.AwardYearID = ay.AwardYearID
         join award aw on ay.AwardID = aw.AwardID
where aw.AwardKoreanTitle = '아카데미 영화제'
group by m.MovieID
order by 노미네이트_횟수 desc
limit 1;
#25 가장 많은 영화에 출연한 여배우를 고르세요.
select p.KoreanName 이름, count(distinct m.MovieID) 출연횟수
from person p
         join appear a on p.PersonID = a.PersonID
         join movie m on a.MovieID = m.MovieID
where p.KoreanName != '수상자 없음'
# and p.gender = '여자'
group by p.PersonID
order by 출연횟수 desc
limit 1;
#26 수익이 가장 높은 영화 TOP 10을 출력하세요.
select KoreanTitle 제목, BoxOfficeWWGross 수익
from movie
order by BoxOfficeWWGross desc
limit 10;
#27 수익이 10억불 이상인 영화중 제작비가 1억불 이하인 영화를 고르시오.
select KoreanTitle 제목, BoxOfficeWWGross 수익, Budget 제작비
from movie
where BoxOfficeWWGross >= 1000000000
  and Budget <= 100000000;
#28 전쟁 영화를 가장 많이 감독한 사람을 고르세요.
select p.KoreanName 이름, count(p.PersonID) 영화수
from person p
         join appear a on p.PersonID = a.PersonID
         join role r on a.RoleID = r.RoleID
         join movie m on a.MovieID = m.MovieID
         join moviegenre mg on m.MovieID = mg.MovieID
         join genre g on mg.GenreID = g.GenreID
where r.RoleKorName = '감독'
  and g.GenreKorName = '전쟁'
group by p.PersonID
order by 영화수 desc
limit 1;
#29 드라마에 가장 많이 출연한 사람을 고르세요.
select p.KoreanName 이름, count(p.PersonID) 출연수
from person p
         join appear a on p.PersonID = a.PersonID
         join role r on a.RoleID = r.RoleID
         join movie m on a.MovieID = m.MovieID
         join moviegenre mg on m.MovieID = mg.MovieID
         join genre g on mg.GenreID = g.GenreID
where g.GenreKorName = '드라마'
  and p.KoreanName != '수상자 없음'
group by p.PersonID
order by 출연수 desc
limit 1;
#30 드라마 장르에 출연했지만 호러 영화에 한번도 출연하지 않은 사람을 고르세요.
select *
from person p;
select p.KoreanName 이름
from person p
         join appear a on p.PersonID = a.PersonID
         join role r on a.RoleID = r.RoleID
         join movie m on a.MovieID = m.MovieID
         join moviegenre mg on m.MovieID = mg.MovieID
         join genre g on mg.GenreID = g.GenreID
where g.GenreKorName = '드라마'
  AND p.PersonID NOT IN (SELECT p.PersonID
                         FROM person p
                                  JOIN appear a ON p.PersonID = a.PersonID
                                  JOIN moviegenre mg ON a.MovieID = mg.MovieID
                                  JOIN genre g ON mg.GenreID = g.GenreID
                         WHERE g.GenreName = '호러')
group by p.PersonID;
#31 아카데미 영화제가 가장 많이 열린 장소는 어디인가요?
select ay.Location 장소, count(ay.Location) 개최횟수
from awardyear ay
         join award a on ay.AwardID = a.AwardID
where a.AwardKoreanTitle = '아카데미 영화제'
group by ay.Location;
#33 첫 번째 아카데미 영화제가 열린지 올해 기준으로 몇년이 지났나요?
select year(now()) - ay.Year 지난연도, ay.year 개최연도
from awardyear ay
         join award a on ay.AwardID = a.AwardID
where a.AwardKoreanTitle = '아카데미 영화제'
order by year
limit 1;